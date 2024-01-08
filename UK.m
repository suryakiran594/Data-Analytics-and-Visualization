% Load data from files
flights_data = readtable('uk_flights.xlsx');
airports_data = readtable('uk_airports.csv');

% Create an undirected graph
G_undirected = graph(flights_data.Source, flights_data.Target);

% Calculate Watts-Strogatz small-world graph
n_nodes = numnodes(G_undirected);
k = 4;  % Average degree of initial regular graph
p = 0.1;  % Probability of rewiring each edge

% Create a directed small-world network
small_world_graph_undirected = wattsStrogatz(n_nodes, k, p);

% Convert the undirected graph to a directed graph
small_world_graph = digraph(small_world_graph_undirected);

% Plot the directed small-world network
figure;
h = plot(small_world_graph, 'NodeLabel', airports_data.airport_name, 'NodeColor', 'skyblue', 'EdgeColor', 'gray', 'Layout', 'force');
title('Directed Watts-Strogatz Small World Network');
