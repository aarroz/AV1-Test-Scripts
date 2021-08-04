#!/bin/bash

# Tested with Latest FFmpeg compiled with SVT-AV1 enabled

# This script is a test suite for 4 video codecs. AV1, VP9, x264, x265
# AV1 is the newest codec from AOM. It is a royalty-free codec that is suppose to compete with x265.
# VP9 is a royalty-free codec from Google, it it used for all Youtube videos. Suppose to be comparable to x265.
# x264 & x265 are proprietary codecs from MPEG-LA, they are the most adopted and are held by patent pools.
# The purpose of this script is to create a reproducable series of tests for anyone who has access to ffmpeg and bash. Therefore, it downloads a free video provided by Netflix for the purpose of testing these encoders.
# The encoding settings have been tested and refined to aim for similar parameters for comparision. SVT-AV1 is chosen over the reference AOM AV1 encoder due to significantly faster performance. No additional parameters have been added for optimization and could well be used to improve quality or performance. Therefore, the current ffmpeg parameters are only aimed to hit a specific bitrate at a fixed resolution. The rest are left to their encoder's defaults.

# Downloads test video from Netflix and renames it to testvideo.y4m
echo "Downloading test file (may take a while)"
wget -O netflix_testvideo.y4m http://download.opencontent.netflix.com.s3.amazonaws.com/aom_test_materials/Chimera/Chimera-ep01_3840x2160_2997fps_10bit_422.y4m

echo "Encoding Test Video Beginning Codec Tests In 5 seconds."
sleep 5

echo "Beginning AV1 encode. (SVT-AV1 Encoder, 1000 kbps, VBR, Preset=5)"
sleep 1
# Marks the time the first encode starts
date +"%H:%M:%S"

# Runs ffmpeg with reduced debug info.
time ffmpeg -i testvideo.y4m -nostats -hide_banner -c:v libsvtav1 -vf scale=1920x1080 -b:v 1000K -rc vbr -preset 5 "Output_Netflix.1920x1080.SVT-AV1.1Mbps.webm"

date +"%H:%M:%S"

echo "Finished AV1"
sleep 2

echo "Starting VP9 encode. (libvpx, 1000 kbps, CBR, Quality=Good)"
sleep 1

date +"%H:%M:%S"

time ffmpeg -i testvideo.y4m -nostats -hide_banner -c:v libvpx-vp9 -vf scale=1920x1080 -minrate 1M -maxrate 1M -b:v 1M -quality good "Output_Netflix.1920x1080.VP9.1Mbps.webm"

date +"%H:%M:%S"

echo "Finished VP9"
sleep 2

echo "Starting x265 encode. (x265, 1000 kbps, CBR, Speed=Medium)"
sleep 1

date +"%H:%M:%S"

time ffmpeg -i testvideo.y4m -nostats -hide_banner -c:v libx265 -vf scale=1920x1080 -minrate 1M -maxrate 1M -b:v 1M -preset medium "Output_Netflix.1920x1080.x265.1Mbps.mkv"

date +"%H:%M:%S"

echo "Finished x265"
sleep 2

echo "Starting x264 encode. (x264, 1000 kbps, CBR, Speed=Medium)"
sleep 1

date +"%H:%M:%S"

time ffmpeg -i testvideo.y4m -nostats -hide_banner -c:v libx264 -vf scale=1920x1080 -minrate 1M -maxrate 1M -b:v 1M -preset medium "Output_Netflix.1920x1080.x264.1Mbps.mkv"

date +"%H:%M:%S"

echo "Finished x264"
sleep 2

echo "Tests complete. Check directory where script was executed for results."

