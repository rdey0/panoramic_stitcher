function H = computeH(t1,t2)
    [~,numCols] = size(t1); 
    A = [];
    %Calculate A
    for i=1:numCols
        x1 = t1(1,i);
        y1 = t1(2,i);
        x2 = t2(1,i);
        y2 = t2(2,i);
        newRows = [x1 y1 1 0 0 0 -x2.*x1 -x2.*y1 -x2; 0 0 0 x1 y1 1 -y2.*x1 -y2.*y1 -y2];
        A = [A;newRows];
    end
    [V,~] = eigs(transpose(A)*A,1,'smallestabs');
    H = transpose(reshape(V,3,3));
end

