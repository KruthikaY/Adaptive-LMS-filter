clear; clc;

% Read entire file as lines
fid = fopen('log.txt');
lines = textscan(fid, '%s', 'Delimiter', '\n'); fclose(fid);
lines = lines{1};

% Preallocate
N = numel(lines);
cycle = []; x = []; d = []; y = []; e = [];
w0 = []; w1 = []; w2 = []; w3 = [];

% Parse only valid numeric lines
for i = 1:N
    line = lines{i};
    if contains(line, 'x=') && ~contains(line, 'x=x')
        vals = sscanf(line, 'Cycle %d | x=%d | d=%d | y=%d | e=%d | w0=%d w1=%d w2=%d w3=%d');
        cycle(end+1) = vals(1);
        x(end+1) = vals(2);
        d(end+1) = vals(3);
        y(end+1) = vals(4);
        e(end+1) = vals(5);
        w0(end+1) = vals(6);
        w1(end+1) = vals(7);
        w2(end+1) = vals(8);
        w3(end+1) = vals(9);
    end
end

% Plot Error
h1 = figure; plot(cycle, e, 'b-o'); grid on;
xlabel('Cycle'); ylabel('Error'); title('LMS Error Over Time');

% Plot Output vs Desired
h2 = figure; plot(cycle, d, 'k--'); hold on;
plot(cycle, y, 'r-'); grid on;
xlabel('Cycle'); ylabel('Amplitude');
legend('Desired d[n]', 'Output y[n]');
title('Output vs Desired');

% Plot Weights
h3 = figure;
plot(cycle, [w0' w1' w2' w3'], 'LineWidth', 1.2);
legend('w0','w1','w2','w3');
xlabel('Cycle'); ylabel('Weight Value');
grid on; title('Weight Convergence');

