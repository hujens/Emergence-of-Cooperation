function [payoff] = neighborhood_watch(world, migration,player_idx)
% Looks around: gets the sum of neighboring payoffs

% We want to observe the neighborhood of size world.m: to identify the
% points in this area we sum to the coordinates of the focal point the
% combinations with repetition of the elements going from -world.m to
% world.m .
v = [-migration.m:1:migration.m];
combs = unique(sort(nchoosek(repmat(v,1,k),k),2),'rows');
combs = combs(sum(combs,2)~=0,:);   % remove central point

to_check = player_idx+combs;    % indeces of points around focal we want to check
rows = to_check(:,1);       columns = to_check(:,2);
idx2check = sub2ind(size(world.composition),rows,columns);  % switch form coordinates to indeces

player_strategy = world.composition(player_idx);    % strategy of focal player
neighbors_strategy = world.composition(idx2check);  % strategy of neighboring player
neighbors_strategy = neighbors_strategy(neighbors_strategy~=0); % remove free slots

sub2sum = [ones(length(neighbors_strategy),1)*player_strategy neighbors_strategy];
idx2sum = sub2ind(size(world.payoff_mat),sub2sum(:,1),sub2sum(:,2));    % switch form coordinates to indeces

% The payoff of the focal player is computed as the sum of the payoffs
% resulting from playing with each one of the neighbors a two player
% Prisoner Dilemma.
payoff = sum(world.payoff_mat(idx2sum),'all');
% NOTE: output new payoff for the focal player. Check in what form is the
% output of cellfun.

% Update map of payoffs
% TODO

end