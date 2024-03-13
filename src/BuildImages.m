function [imageArray, imageTarget] = BuildImages(Array,offset,target)
imageArray = [];
sizeImage = length(Array(:,1));
numImages = (length(Array)-offset)/(sizeImage-offset);
numImages = floor(numImages);

for i = 1: numImages
   image=Array(:, (i-1)*sizeImage-(i-1)*offset + 1 :(i)*sizeImage-(i-1)*offset); 
   imageArray = cat(4,imageArray,image);
end
imageTarget=zeros(numImages,1);
imageTarget(:)=target;
end