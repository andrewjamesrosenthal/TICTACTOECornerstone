% Andrew and Sean 10/3/24

function [isTaken] = checktaken_JR(arr, cell)
% Inputs:
%   arr - A 1x9 array representing the tic-tac-toe board.
%   cell - position in the array
% Outputs:
%   isTaken - boolean set to true if cell is not 0 and false if it is 0
%
% Description:
%   Function checks to see the location in the array is taken returns true
%   if is taken and false if it is not taken

    isTaken = arr(cell) ~= 0;
end
