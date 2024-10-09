% Andrew and Sean 10/1/24
function [winner, start, finish] = Checkwin_JR(arr)
% Inputs:
%   arr - A 1x9 array representing the tic-tac-toe board.
% Outputs:
%   winner - The player number 1 or 2 depending on the winner -1 if it is 
%            a Tie and 0 if there is no winner
%   start  - The index of the first position in the winning combination.
%            Returns 0 if there is no winner or a tie.
%   finish - The index of the last position in the winning combination.
%            Returns 0 if there is no winner or a tie.
%
% Description:
%   Checks to see if there is a winner in the game, looks at all of the
%   possible winning combos and if they are all 1s or 2s there is a winner
%   it then checks to see if there is no winner and if all of the elements
%   are non zero which means it is a tie


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







    