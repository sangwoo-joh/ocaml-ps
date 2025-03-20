from typing import Dict, Set, override
from collections import deque

class Graph:
    class Edge:
        sink: int
        weight: int

    n_vertices: int
    n_edges: int
    directed: bool
    edges: Dict[int, Set[Edge]]

    def __getitem__(self, key: int):
        if key in self.edges:
            return self.edges[key]
        return set()


class Traverse:
    visited: Set[int]
    discovered: Set[int]
    parent_info: Dict[int, int]

    @override
    def visit_vertex_early(self, x: int):
        ...

    @override
    def visit_vertex_late(self, x: int):
        ...

    @override
    def visit_edge(self, source: int, sink: int):
        ...

    def bfs(self, graph: Graph, start: int):
        q = deque()
        q.append(start)
        self.discovered.add(start)

        while q:
            src = q.popleft()
            self.visit_vertex_early(src)
            self.visited.add(src)
            for edge in graph[src]:
                if edge.sink not in self.visited or graph.directed:
                    self.visit_edge(src, edge.sink)
                if edge.sink not in self.discovered:
                    q.append(edge.sink)
                    self.discovered.add(edge.sink)
                    self.parent[edge.sink] = src
            self.visit_vertex_late(src)
