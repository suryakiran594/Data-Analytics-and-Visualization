% Load data from Excel and CSV files
flights_data = readtable('aus_flights.xlsx');
airports_data = readtable('aus_airports.csv');

% Create a directed graph
G = digraph();

% Add nodes and edges with weights
for index = 1:size(flights_data, 1)
    source = flights_data.SourceCity{index};
    target = flights_data.TargetCity{index};
    weight = flights_data.Weight(index);
    G = addedge(G, source, target, weight);
end

% Create a graph plot
figure;
p = plot(G, 'EdgeLabel', G.Edges.Weight, 'NodeLabel', G.Nodes.Name);

% Customize node positions based on airport coordinates
for index = 1:size(airports_data, 1)
    id = airports_data.id(index);
    x = airports_data.Lon(index);
    y = airports_data.Lat(index);
    
    % Find node index in G
    node_index = find(strcmp(G.Nodes.Name, id));
    
    % Update node positions
    p.XData(node_index) = x;
    p.YData(node_index) = y;
end

% Customize plot appearance
title('Spatial Directed Graph with Airports- Australia');
xlabel('Longitude');
ylabel('Latitude');