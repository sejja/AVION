input_folder="../../../../media/ud/Nuevo vol/CNNS/AVION/datasets/EGO4D/temp/v2/full_scale"
output_folder="../../../../media/ud/Nuevo vol/CNNS/AVION/datasets/EGO4D/video_320px_15sec"

# Create output folder if it doesn't exist
mkdir -p "$output_folder"

# Iterate through all .mp4 files in the input folder
for file in "$input_folder"/*.mp4; do
    echo "$file" 
    filename=$(basename -- "$file")
    filename_no_ext="${filename%.*}"
    output_path="$output_folder/$filename_no_ext"

    mkdir -p "$output_path"
    
    # Resize the video to 288 pixels width
    ffmpeg -i "$file" -vf "scale=288:-1" -c:a copy "$output_path/0.mp4"

    # Split the resized video into chunks of 15 seconds
    ffmpeg -i "$output_path/0.mp4" -c copy -map 0 -segment_time 15 -f segment "$output_path/%03d.mp4"

    # Delete the input file
    rm "$file"

    # Delete the resized whole video
    rm "${output_path}/0.mp4"
done
