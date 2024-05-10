input_folder="../../../../media/ud/Nuevo vol/CNNS/AVION/datasets/EGO4D/video_320px_15sec"

for subfolder in "$input_folder"/*/; do
	for file in "$subfolder"*.mp4; do
		filename=$(basename -- "$file")
		filename_no_ext="${filename%.*}"
		dir_name=$(basename -- "$subfolder")
		numeric_part=$(echo "$filename_no_ext" | sed 's/^0*//')
		new_timestamp=$((numeric_part * 15))
		new_filename="$subfolder$new_timestamp.mp4"
		mv "$file" "$new_filename"
	done
done
