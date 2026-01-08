import argparse
import os
import tifffile
import zarr
import dask.array as da
import numpy as np

def max_projection(
    input_path,
    channel_file
):
    in_tif = tifffile.TiffFile(input_path, is_ome=False)
    in_data = zarr.open(in_tif.series[0].aszarr())
    
    # Read channel indices:
    with open(channel_file, 'r') as fh:
        channels = fh.readlines()
        channels = [int(c) for c in channels[1].split(',')]
        
    # Select indices for max projection:
    subset = in_data["0"][channels, :, :]
    max_proj = subset.max(axis=0)
    #return channels
    basename = os.path.basename(input_path).split('.')[0]
    
    #maxproj_image = da.stack([in_data[0], max_proj], axis=0)
    
    #tifffile.imwrite(basename + '_max_projected.tif', max_proj[:])
    maxproj_image = np.stack([in_data["0"][0,:,:], max_proj], axis=0)
    
    tifffile.imwrite(basename + '_max_projected.tif', data=maxproj_image, ome=True, bigtiff=True, metadata={'axes': 'CYX', 'Channel': {'Name': ['DAPI', 'MaxProj']}}, photometric='minisblack')

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Max projection of selected channels from a multi-channel zarr tiff.")
    parser.add_argument("--input_path", type=str, help="Path to the input multi-channel zarr tiff file.")
    parser.add_argument("--channel_file", type=str, help="Path to the channel index file.")
    
    args = parser.parse_args()
    
    c = max_projection(
        input_path=args.input_path,
        channel_file=args.channel_file
    )