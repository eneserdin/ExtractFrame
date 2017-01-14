# ExtractFrame
Extract farmes from a video

# The link I used is this
http://video.stackexchange.com/questions/4563/how-can-i-crop-a-video-with-ffmpeg

# Some commands
in order to crop some part of the image you can write this
ffmpeg -i led.mp4 -filter:v "crop=75:75:350:25" out.mp4

if you want to preview the changes before you apply:
ffplay -i led.mp4 -vf "crop=75:75:350:25"

after all in order to extract image files from the video here the code is
ffmpeg -i out.mp4 -r 30 $filename%03d.bmp
