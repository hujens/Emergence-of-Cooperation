%% Main code
%
% Here is where all the functions should be called
    
%% Tabula Rasa
close all
clear all

%% World parametrs structure

global world

% Grid
world.L = 5; % sidelength of the board

% Game Type
world.migration = true;     % input for game whether there should be migration {true,false}
world.loners = false;        % or loners  {true,false}
world.noise = false;         % or noise  {true,false}

world.rounds = 5; % amount of rounds to be played

% Player distribution
world.density = 0.75; % what percentage of the grid should be populated [0,1], Attention: if density is 1, migration is not possible
world.n = round(world.density * (world.L)^2); %total number of players, rounds as we can't have non integer amount of players
world.N = 5;         % number of people offered to play the game
world.p_cooperators = 0.4;          % percentage of cooperators
world.p_loners =   0.2;    % percentage of loners

if world.loners == false  %if we have loners disabled, we ignore the value above and set it to 0
    world.loners = 0;
end
world.p_defectors = 1 - (world.p_cooperators+world.p_loners);            % percentage of defectors

world.n_cooperators = world.p_cooperators*world.n;
world.n_defectors = world.p_defectors*world.n;
world.n_loners = world.p_loners*world.n;

% Strategy Parameters
T = 5;  R = 3;  P = 1;  S = 0.5;
world.payoff_mat = [R S; T P];


% DEBUG
if and(world.density == 1, world.migration == true)
    error("ERROR: migration is not possible without free fields (M = 1)")
end

if (world.N > world.n)
   error("ERROR: You can't choose more players to play than you have! (N>n)")
end

%% Initialize 
% Call init function
init();

%% Run Game

% play test iterations within mobility Range to find the free square
% with the highest expected payoff

global game

game.migration = true;
game.p_migration = 0.5;    % probability to imitate better strategies

game.imitation = true;
game.p_imitation = 0.5;    % probability to migrate to more favorable areas

game.m = 1;    % neighborhood dimension
game.M = 2;    % mobility range

% move focal player to said square

% let players play game in their Neuman Neighborhood
last_game = migration();

%
% adapt strategy of neighbor if overall payoff of neighbor was higher than
% that of the focal player (choose closest if there are multiple options)
% if noise == true
% apply stragegy mutations (noise_1)
% apply random relocations (noise_2)
% (do both if we have noise_3)2
% end
%

