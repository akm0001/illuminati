#!/usr/bin/env ruby

LIMS_SCRIPT_PATH = "/n/ngs/tools/lims/lims_data.pl"

MAIL_SCRIPT_PATH = "/n/ngs/tools/pilluminati/bin/emailer.rb"

require 'json'

flowcell_id = ARGV[0]

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text); colorize(text, 31); end
def green(text); colorize(text, 32); end
def cyan(text); colorize(text, 36); end

def json_data_for flowcell_id
  script = "perl #{LIMS_SCRIPT_PATH}"
  lims_results = %x[#{script} #{flowcell_id}]
  lims_results.force_encoding("iso-8859-1")
  data = {"samples" => []}
  unless lims_results =~ /^[F|f]lowcell not found/
    data = JSON.parse(lims_results)
  end
  data
end

def check_barcodes flowcell_data

	rtn = true
	single = false
	custom = false
	custom_lanes = []

	if flowcell_data['samples'].size < 1
		puts red('flowcell not found')
	end

	flowcell_data['samples'].each do |sample|
		if sample['indexSequences']
			if sample['indexSequences'] == [""]
				puts cyan("indexSequences is blank, lane #{sample['laneID']}. Verify that this was intentional in lims and it should be okay.")
			end
			if sample['indexSequences'].size > 1
				rtn = false
			else
				single = true
			end
			
		else
			 puts cyan("no indexes, lane #{sample['laneID']}. Verify that this was intentional in lims and it should be okay.")
		end

		if sample['indexType'] == "Single Custom"
			custom = true
			custom_lanes << sample['laneID']
		end
	end

	if custom
		puts red("indexType is single custom, lane #{custom_lanes.uniq.join(",")}. Pipeline doesn\'t really deal with this yet. Create custom SampleSheet.csv to run pipeline or add Indexes to lims and update external_data_lims.rb with the new type.")
	else
		if !rtn and single
			puts red('mix of dual and single indexes found. Check in lims - may be a dual indexed library run as single. Modify SampleSheet.csv.')
		else
			if !rtn and !single
				puts red('dual indexes found. Run startup_run.rb with --dual')
			else
				puts green("all single indexes.")
			end
		end
	end
	rtn
end

def check_genomes flowcell_data
	species = ""
	rtn = true
	missing_lanes = []
	genomes = []
	flowcell_data['samples'].each do |sample|
		if sample.include?('genomeVersion')
			genomes << sample['genomeVersion']
			if sample['genomeVersion'].strip.size == 0 or sample['genomeVersion'].strip.downcase == 'none'
				rtn = false
				missing_lanes << sample['laneID']
				species = sample['speciesName']
			else
				if sample['speciesName'][0].downcase != sample['genomeVersion'][0].downcase
					puts cyan("species name and genome check: #{sample['speciesName']} #{sample['genomeVersion']}")
				end
			end
		else
			if sample['isControl'] == 1
				puts cyan("control has no genome. Should be okay.")
			else
				rtn = false
				missing_lanes << sample['laneID']
			end
		end
	end
	if !rtn
		puts cyan("missing genome: #{missing_lanes.uniq.join(",")}. Species is #{species}. To run without alignment, do startup_run.rb FCID --no-align")
	else
		puts green("genomes: #{genomes.uniq.join(",")}.")
	end
	rtn
end

def check_machine flowcell_data
	rtn = true
	missing_lanes = []
	flowcell_data['samples'].each do |sample|
		if sample['readLength'] =~ /^N/
			puts red("Nextseq run. Do /n/ngs/tools/nextseq/illuminati/bin/startup_run.rb FCID --nextseq.")
		end
	end
	rtn
end

def check_paired flowcell_data
	missing_lanes = []
	rtn = true
	previous = flowcell_data['samples'][0]['readType']
	flowcell_data['samples'].each do |sample|
		if (sample['readType'] == 'Single Read' or sample['readType'] == 'Paired Reads') and sample['readType']==previous
			previous=sample['readType']
		else
			rtn = false
			missing_lanes << sample['laneID']
		end
	end
	if !rtn
		puts red("mixed Single Read / Paired Reads on the same flowcell, manually edit the config.txt file for lane #{missing_lanes.uniq.join(",")}.")
	end
	rtn
end

def check_lims flowcell_id
  rtn = true
  flowcell_data = json_data_for(flowcell_id)
  barcodes = check_barcodes(flowcell_data)
  genomes = check_genomes(flowcell_data)
  machine = check_machine(flowcell_data)
  paired = check_paired(flowcell_data)

  if !barcodes
    rtn = false
  end

  rtn
end

valid = check_lims(flowcell_id)

# valid = false

