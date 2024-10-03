% Andrew and Sean 10/1/24

% pseudo code
% 3 main cases:

% 1.)
% starting at the center check if cells in opposite directions of each
% other are all the same values as the center 
% these lines: \ | / -

% 2.)
% check top left corner and check the horizontal and vertical line

% 3.)
% check the bottom right and check the horizontal and vertical line

% "checking" entails checking the focal cell's mark and seeing if it is the
% same as the two others that are colinear with it.

function [winner, start, finish] = Checkwin_AS(arr)
    % check anything through the center  
    if arr(5) ~= 0
        mark = arr(5);
        for i = 1:4
            if arr(5-i) == mark && arr(5+i) == mark
                winner = mark;
                start = 5-i;
                finish = 5+i;
                return
            end
        end
    end
    % check top left
    if arr(1) ~= 0
        mark = arr(1);
        for i = [1 3]
            if arr(1+i) == mark && arr(1+2*i) == mark
                winner = mark;
                start = 1+i;
                finish = 1+2i;
                return
            end
        end
    end
    % check bottom right
    if arr(9) ~= 0
        mark = arr(9);
        for i = [-1 -3]
            if arr(9+i) == mark && arr(9+2*i) == mark
                winner = mark;
                start = 9+i;
                finish = 9+2i;
                return
            end
        end
    end
    winner = 0;
    start = 0;
    finish = 0;
end


    