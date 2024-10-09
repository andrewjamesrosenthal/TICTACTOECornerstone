% Sean and Andrew 10/8/24
function [] = flipcoin_JR()
    

    %load soundeffect
    [flipSnd, flipFs] = audioread('flip.mp3');
    flipFs = flipFs/2.5;  % modified to be longer

    % coin flipping frames and respective pause times
    coinFrames = ["\n----\n", "\\\n \\\n  \\\n", " |\n |\n |\n", "  /\n /\n/\n"];
    pTimes = [0.3, 0.2, 0.2, 0.3] / 4;
    
    % animation settings
    dt = 1/20;  % seconds per frame
    ttot = 2.5; % total time
    yi = -25;   % # of blank lines at bottom
    
    % math behind vyi and a values
    % derived from -a/2t^2+vy*t+y are the following:
        % ttot = 2v / -a
            % -a = 2v / ttot
        % y = v^2 / (-2a)
            % y = v^2 / (2*2v/ttot)
            % y = v * ttot / 4
            % v = 4y / ttot  (then plug back into first eq)
        % final equations:
            % v = 4y / ttot
            % a = -2v / ttot
    
    % calc vyi and a
    vyi = 4 * (-yi) / ttot;
    a = -2 * vyi / ttot;
    
    % inditialize 
    frameInd = 1;
    frameTime = 0;
    
    clc;
    % shows the coin
    fprintf(join(repelem("\n", ceil(-yi))));
    fprintf(coinFrames(frameInd));
    % waits for user to commence the flip
    input('Press enter to flip a coin to determine who goes first: ', 's');
    clc;
    fprintf(join(repelem("\n", ceil(-yi))));
    fprintf(coinFrames(frameInd));
    pause(0.5)
    
    % play sound
    sound(flipSnd,flipFs);
    
    % animation loop
    for t = 0:dt:ttot
        % update y
        y = a/2*t*t+vyi*t+yi;
        
        % update frameInd
        if (frameTime >= pTimes(frameInd))
            frameInd = mod(frameInd, 4)+1;
            frameTime = frameTime - pTimes(frameInd);
        end
        
        % display coin
        clc;
        if y < 0
            fprintf(join(repelem("\n", ceil(-y))));
        end
        fprintf(coinFrames(frameInd));
    
        % wait for next frame
        pause(dt);
        frameTime = frameTime + dt;
    end
    pause(0.25)
    
    clc;
    disp("          __-----__")
    disp("     ..;;;--'~~~`--;;;..")
    disp("   /;-~IN GOD WE TRUST~-.\")
    disp("  //      ,;;;;;;;;      \\")
    disp(".//      ;;;;;    \       \\")
    disp("||       ;;;;(   /.|       ||")
    disp("||       ;;;;;;;   _\      ||")
    disp("||       ';;  ;;;;=        ||")
    disp("||LIBERTY | ''\;;;;;;      ||")
    disp(" \\     ,| '\  '|><| 1995 //")
    disp("  \\   |     |      \  A //")
    disp("   `;.,|.    |      '\.-'/")
    disp("     ~~;;;,._|___.,-;;;~'")
    disp("         ''=--'")
end