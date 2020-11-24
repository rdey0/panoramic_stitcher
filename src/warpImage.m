function [warpIm,mergeIm] = warpImage(inputIm,refIm, H)

[inputImRows,inputImCols,~] = size(inputIm);
[refImRows,refImCols,~] = size(refIm);
points = zeros(2,8);

inputImCorners = [0 inputImCols 0 inputImCols; 0 0 inputImRows inputImRows; 1 1 1 1];
inputCornerWarp = H*inputImCorners;
points(:,1:4) = inputCornerWarp(1:2,:) ./ inputCornerWarp(3,:);
points(:,5:end) = [0 refImCols 0 refImCols; 0 0 refImRows refImRows];

colMin = min(points(1,:));
rowMin = min(points(2,:));
colMax = max(points(1,:));
rowMax = max(points(2,:));

shiftX = colMin;
shiftY = rowMin;

warpIm = zeros(ceil(rowMax)-ceil(rowMin),ceil(colMax)-ceil(colMin),3);
[boxRows,boxCols,~] = size(warpIm);

warpIm = zeros(boxRows,boxCols,3);

for r=1:boxRows
    for c=1:boxCols
        warpedPoint = inv(H)*[c+shiftX;r+shiftY;1];
        col = warpedPoint(1) ./ warpedPoint(3);
        row = warpedPoint(2) ./ warpedPoint(3);
        i = floor(col);
        j = floor(row);
        % check that it is withing boundaries of original photo
        if(i < 1 || i >= inputImCols || j < 1 || j >= inputImRows)
            continue;
        end
        a = col - i;
        b = row - j;
        for color=1:3
            warpIm(r,c,color) = (1-a)*(1-b)*inputIm(j,i,color) + a*(1-b)*inputIm(j,i+1,color) ...
            + a*b*inputIm(j+1,i+1,color) + (1-a)*b*inputIm(j+1,i,color);
        end
    end
end

addY = 0;
if boxRows <= ceil(abs(shiftY)) + refImRows
    addY = ceil(abs(shiftY)) + refImRows - boxRows;
end
addX = 0;
if boxCols <= ceil(abs(shiftX)) + refImCols
    addX = ceil(abs(shiftX)) + refImCols - boxCols;
end
y_zero = zeros(addY, boxCols + addX, 3);
x_zero = zeros(boxRows,addX,3);
mergeIm = [warpIm x_zero; y_zero];

mergeIm = uint8(mergeIm);
warpIm = uint8(warpIm);

for i=1:refImRows
    for j=1:refImCols
        for c=1:3
            mergeIm(i+floor(abs(shiftY)),j+floor(abs(shiftX)),c) = refIm(i,j,c);
        end
    end
end

end