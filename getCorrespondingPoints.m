% Pass in the two images you want to stitch together as arguments and manually select 
% corresponding points
function [leftPoints,rightPoints] = getCorrespondingPoints(leftImg,rightImg)
[leftPoints,rightPoints] = cpselect(leftImg,rightImg,'Wait',true);
%leftPoints = rescale(transpose(leftPoints),0,2);
%rightPoints = rescale(transpose(rightPoints),0,2);
leftPoints = transpose(leftPoints);
rightPoints = transpose(rightPoints);
end

