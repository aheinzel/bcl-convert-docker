# BCL Convert Docker

Docker image for Illumina's BCL Convert.

## How to build
 - Clone this repository
 - Change into the repository folder
 - Download latest version of bcl-convert from
   Ilumina [BCL Convert Support(illumina.com)](https://emea.support.illumina.com/sequencing/sequencing_software/bcl-convert.html) and store it in the same folder as the Dockerfile file.  
  - Create a soft link named bcl-convert.rpm pointing to the downloaded rpm `ln -s bcl-convert-4.1.5-2.el7.x86_64.rpm bcl-convert.rpm`
  - Build the image

```
git clone git@github.com:aheinzel/bcl-convert-docker.git
cd bcl-convert-docker
#curl ... to download bcl-convert from illumina
ln -s bcl-convert-4.1.5-2.el7.x86_64.rpm bcl-convert.rpm
docker build -t aheinzel/bcl-convert .
```


## How to run this image with singularity
 - Build sif image from docker image (only required once)
   - Export docker image to tar archive
   - Build sif image from docker image tar archive
 - Run sif image

```
#prepare SIF image (one time only)
docker save aheinzel/bcl-convert -o bcl-convert.tar
##in case tmp has been mounted with nodev - use a different temp dir
export TMPDIR=/path/to/new/tmp/dir
singularity build bcl-convert.sif docker-archive://bcl-convert.tar

#run newly created SIF image
singularity \
   run \
   --contain \
   --ipc \
   --cleanenv \
   --net \
   --network none \
   --writable-tmpfs \
   --bind XXX:/work \
   bcl-convert.sif \
      --bcl-input-directory /work/YYY \
      --output-directory /work/YYY_FASTQ \
      --no-lane-splitting true
```
** replace XXX with the path of the folder that should be made available in the container and YYY with the name of your run folder **
