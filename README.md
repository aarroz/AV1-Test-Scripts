# AV1-Test-Scripts
FFmpeg scripts written for the purpose of benchmarking AV1 against current common web codecs

Latest Version of ffmpeg compiled with SVT-AV1 required.

These scripts download a specific video file and transcode them through ffmpeg into 4 codecs. AV1, VP9, H.264 and H.265.

How to use: Download a script and put it in a directory. Execute it with bash. ``chmod +x`` the script if it lacks execution permissions. This will download a video file into the directory and create 4 additional files.

### Current Scripts:
#### CodecTestSuite_SVT-AV1_NetflixSource
- Source Video from Netflix's Open Content. (4K, 4:2:2, YUV12)
- Encodes video to 1000 kbps.
- Uses medium preset with no thread optimizations or additional metadata defined.
- Source File Size: 7,431,783,724 bytes
- Expected Output Size: <1M

**Results:**
- AV1 has the least noticable blocky distortion compared to the rest of the codecs. 
- x265 comes close with similar perceptual performance in the dark shirt, but suffers around edges and movement. AV1 handles edges and movement pretty well compared to x265. 
- VP9 is blocky, but handles gradient luminance changes better than x264. 
- x264 looks the worse with blocky artifacts that flicker trying to smooth the shirt's gradient.
