def traverse(graph, start):
    container.append(start)
    discovered[start] = True

    while not container.empty():
        pioneer = container.pop()
        visited[pioneer] = True
        process_vertex_early(pioneer)

        for neighbor in graph[pioneer]:
            if neighbor not in visited or graph.directed:
                process_edge(pioneer, neighbor)
            if neighbor not in discovered:
                container.append(neighbor)
                discovered[neighbor] = True
                parent[neighbor] = pioneer

        process_vertex_late(pioneer)
