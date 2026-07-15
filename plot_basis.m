%Plot basis




% plot basis functions
function [Images] = plot_basis(InputBasisMatrix)

[m,n] = size(InputBasisMatrix);

no_columns = ceil(sqrt(n));
m_root = ceil(sqrt(m));
m_new = m_root^2;

IBM_new  = zeros(m_new,n);
IBM_new(1:m,1:n) = InputBasisMatrix;
InputBasisMatrix = IBM_new;
m = m_new;
Images = zeros(no_columns*sqrt(m)+no_columns+1,(no_columns-1)*sqrt(m)+no_columns);

for i = 1 : n
    B = reshape(InputBasisMatrix(:,i),sqrt(m),sqrt(m));
    image_col = (floor((i-1)/no_columns))*sqrt(m)+1;
    image_row = (mod((i-1),no_columns))*sqrt(m)+1;

    Images(image_row+mod((i-1),no_columns)+1:image_row+mod((i-1),no_columns)...
        +sqrt(m),image_col+floor((i-1)/no_columns)+1:image_col+...
        floor((i-1)/no_columns)+sqrt(m)) = B;
    
    
    
    
end

imshow(Images)


return