<h1 align='center' >Panoramic Stitcher</h1>
<div>
    <img src='https://img.shields.io/badge/MATLAB-9.6-blue' alt='MATLAB 9.6'>
    <img src='https://img.shields.io/badge/Topic-Computer%20Vision-green' alt='Topic: Computer Vision'>
    <img src='https://img.shields.io/badge/Status-Open%20Source-orange' alt='Status: Open source'>
</div>
<img width="100%" height='50%'src='./assets/images/cropMerge.png'/>

<h1></h1>

## Description

The panoramic stitcher allows you to combine multiple photos with overlapping content into a unified, panoramic image. The panoramic stitcher warps images such that they are in the same perspective and then merges the images together to achieve this panoramic effect.

## How it Works

### 1. Select Corresponding Points

Foremost, in order for the stitcher to combine multiple photos, it needs to know where overlapping content is located in the provided photos. Overlapping content is simply any visual content that can be seen in both photos. For example, two images that are to be stitched together may both contain the same chair. This chair is considered overlapping content, and it allows the panoramic stitcher to determine any differences in the two image's perspective.

In order to pinpoint overlapping content, the user manually selects corresponding points in the two images to be merged. The corresponding points are stored in two matrices `P1` and `P2` where `P1[n]` and `P2[n]` represent corresponding points in each image. The result of the process looks like this:

<br/>

<div align='center'>
    <img margin='0' padding='0' width='47%' src='./assets/images/partBCrop1.png'>
    <img margin='0' padding='0' width='47%' src='./assets/images/partBCrop2.png'>
    <p align='center'><b>Two images of the same crop circle marked with corresponding points</b></p>
</div>

<br/>

### 2. Warp the Image

The images must now be altered such that they are in the same perspective. The same perspective, in our case, means that if you were to cast a ray from where you are standing through a point in one image, it would intersect with the corresponding point in the second image.

<br/>

<div align='center'>
    <img margin='0' padding='0' src='./assets/images/perspective.PNG'>
    <p align='center'><b>The points of image 1 project onto corresponding points on image 2</b></p>
</div>

<br/>

In order to achieve this, we shift the perspective of, or warp, image 1 (the first image input) to match the perspective of image 2. To do this, we find a mapping between the two sets of corresponding points `P1` and `P2`. This mapping is called a homography matrix, `H`, and is represented by the equation `P1 = H * P2`. We solve for `H` using simple linear algebra and then apply the homography matrix to image 1 via matrix product, effectively warping it. The result of a warp looks like this:

<br/>

<div align='center'>
    <img margin='0' padding='0' width='47%' src='./assets/images/partBCrop1.png'>
    <img margin='0' padding='0' width='47%' src='./assets/images/cropWarp.png'>
    <p align='center'><b>The left image is the original and the right image is its warped counterpart</b></p>
</div>

<br/>

### 3. Combine Images

Now that both images are in the same perspective, all that's left to do is to align the two images based on their corresponding points, thus merging the images. This process can be repeated with as many photos an desired. The end result looks like this:

<br/>

<div align='center'>
    <img margin='0' padding='0' width='45%' src='./assets/images/partBCrop1.png'>
    <img margin='0' padding='0' width='45%' src='./assets/images/partBCrop2.png'>
    <p align='center'><b>Image 1 (left) and Image 2 (right)</b></p>
    <img margin='0' padding='0' src='./assets/images/cropMerge.png'>
    <p align='center'><b>Merged Image</b></p>
</div>

<br/>

## How to Use

1. Download Files in `./src`

2. Run `getCorrespondingPoints.m`. Two images are accepted as input

3. Run `computeH.m`

4. Run `warpImage.m`

