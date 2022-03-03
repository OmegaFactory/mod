# Helper generating UI mats and tobj files (if not exists) for list of the tga files

# Command line:
# --verbose - Enable logging of each operation.

if !ARGV.index("--help").nil? then
	print ("--verbose - Enable logging of each operation.\n");
	print ("--help - Show help.\n");
	exit
end

$verbose_mode = !ARGV.index("--verbose").nil?

print ("Need help? Add --help commandline switch.\n")

# List of the source tga files used for generation (without extension)
def collect_tga_files()
	print("Collecting tga files..") if $verbose_mode
	files = []
	Dir.foreach(".") do |file|
		if file.end_with? ".tga" then
			file_without_extension = file[0..file.rindex(".tga")-1]
			files << file_without_extension

			print("File #{file_without_extension} found.\n") if $verbose_mode
		end
	end
	printf("Collect %i files!\n", files.size) if $verbose_mode

	return files
end


def generate_mat_tobj(file)
	print "Generating tobj and mat for #{file}..\n" if $verbose_mode

	# Generate mat file

	mat_file = "#{file}.mat"
	if File.exists?(mat_file) then
		print "Skipping #{mat_file} generation - already exists.\n" if $verbose_mode
	else
		print "Generating mat - > #{mat_file}..\n" if $verbose_mode

		mat = open(mat_file, "w")

		printf(mat, <<EOF
material : "ui"
{
	texture : "#{file}.tobj"
	texture_name : "texture"
}
EOF
		)

		mat.close

		print "Mat generated!\n" if $verbose_mode
	end

	# Generate tobj file

	tobj_file = "#{file}.tobj"
	if File.exists?(tobj_file) then
		print "Skipping #{tobj_file} generation - already exists.\n" if $verbose_mode
	else
		print "Generating tobj - > #{tobj_file}..\n" if $verbose_mode

		tobj = open(tobj_file, "w")

		printf(tobj, <<EOF
map	2d	#{file}.tga
addr	clamp_to_edge	clamp_to_edge
usage	ui
EOF
			)

		tobj.close

		print "Tobj generated!\n" if $verbose_mode
	end
end

collect_tga_files().each do |file|
	generate_mat_tobj(file)
end

print "Done!"

#eof
