function [winner, start, finish] = Checkwin_AS(arr)
    % check anything through the center  
    if arr(5) ~= 0
        mark = arr(5);
        for i = 1:4
            if arr(5-i) == mark && arr(5+i) == mark
                winner = mark;
                start = arr(5-i);
                finish = arr(5+i);
                return
            end
        end
    end
    if arr(1) ~= 0
        mark = arr(1);
        for i = [1 3]
            if arr(1+i) == mark && arr(1+2*i) == mark
                winner = mark;
                start = arr(1+i);
                finish = arr(1+2i);
                return
            end
        end
    end
    if arr(9) ~= 0
        mark = arr(9);
        for i = [-1 -3]
            if arr(9+i) == mark && arr(9+2*i) == mark
                winner = mark;
                start = arr(9+i);
                finish = arr(9+2i);
                return
            end
        end
    end
    winner = 0;
    start = 0;
    finish = 0;
end


    