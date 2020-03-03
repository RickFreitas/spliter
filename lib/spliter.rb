require 'roo'
require 'write_xlsx'
require 'rubyXL'



class Spliter
	puts "Carregando arquivo..."
	arq = ARGV[0]
	input = Roo::Excelx.new(arq)
	row_count = input.last_row
	column_count = input.last_column
	split_count = 0
	while split_count == 0
		puts "O arquivo tem #{row_count} linhas. Em quantos arquivos vc vai querer separar?"
		split_count = STDIN.gets.chomp[0..1].to_i
	end
	row_per_file = (row_count - 1)/split_count
	resto = (row_count-1)%split_count

	puts "Separando em #{split_count} arquivos. Cada arquivo terá #{row_per_file} linhas"

	copied_rows = 1

	for i in 1..split_count
		helper = 0
		# creating workbooks
		row_count_this = 0
		
		workbook_name = "#{arq} - part#{i}.xlsx"
		workbook = WriteXLSX.new(workbook_name)
		worksheet = workbook.add_worksheet
		workbook.close

		# reading new workbooks
		roo_workbook = RubyXL::Parser.parse(workbook_name)
		roo_worksheet = roo_workbook[0]

		# copying header
		for column in 0..column_count
			roo_worksheet.add_cell(0,column,input.cell(1,column+1)) #input.cell(0,0) return nil on Roo. It starts in (1,1)
		end

		# copying rows to new workbooks
		if i == split_count
			helper = resto
		end

		for row in 1..(row_per_file+helper)
			for column in 0..column_count
				roo_worksheet.add_cell(row,column,input.cell(copied_rows+1,column+1))
			end
			copied_rows = copied_rows + 1
			row_count_this = row_count_this + 1
		end

		puts "Criando arquivo #{i}, #{row_count_this} linhas."
		roo_workbook.write(workbook_name)
	end
end