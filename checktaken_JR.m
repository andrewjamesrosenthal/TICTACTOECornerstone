% Andrew and Sean 10/3/24

% pseudo code
% return if that cell in the array is not 0 (means it is taken by a x or o)
function [isTaken] = checktaken_JR(arr, cell)
    isTaken = arr(cell) ~= 0;
end
