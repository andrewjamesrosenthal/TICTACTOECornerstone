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

function [winner, start, finish] = Checkwin_JR(arr)
    % Initialize output variables
    winner = 0;
    start = 0;
    finish = 0;

    % Define all possible winning combinations
winning_combos = [1 2 3; 4 5 6; 7 8 9; 1 4 7; 2 5 8; 3 6 9; 1 5 9; 3 5 7];


    % Loop through each winning combination
    for i = 1:size(winning_combos, 1)
        combo = winning_combos(i, :);
        if arr(combo(1)) ~= 0 && arr(combo(1)) == arr(combo(2)) && arr(combo(2)) == arr(combo(3))
            winner = arr(combo(1));
            start = combo(1);
            finish = combo(3);
            return;
        end
    end

    % Check for a tie (no winner and all elements are non-zero)
    if winner == 0 && all(arr ~= 0)
        winner = -1; % Use -1 to indicate a tie
        start = 0;
        finish = 0;
    end
end







    