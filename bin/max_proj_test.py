import argparse
import os
import tifffile
import dask.array as da
import zarr

def max_projection(
    input_path,
    channel_file
):
    in_tif = tifffile.TiffFile(input_path, is_ome=False)
    in_data = zarr.open(in_tif.series[0].aszarr())
    #print(in_data)
    
    
    # Read channel indices:
    with open(channel_file, 'r') as fh:
        channels = fh.readlines()
        channels = channels[1].split(',')[:-1]
        
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Max projection of selected channels from a multi-channel zarr tiff.")
    parser.add_argument("--input_path", type=str, help="Path to the input multi-channel zarr tiff file.")
    parser.add_argument("--channel_file", type=str, help="Path to the channel index file.")
    
    args = parser.parse_args()
    
    max_projection(
        input_path=args.input_path,
        channel_file=args.channel_file
    )