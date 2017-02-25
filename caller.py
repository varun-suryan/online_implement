import numpy as np
import matplotlib.pyplot as plt

import planner
updateObj = planner.gprmax()

GRID = 3

states = [(x,y) for x in range(-GRID, GRID + 1) for y in range(-GRID, GRID + 1)]
actions=[(1,0), (-1,0), (0,1), (0,-1)]
T = {}

#T = {(s, a): [(s[0] + a[0], s[1] + a[1]), 1]}

for s in states:
	for a in actions:
		temporary = {(s, a): [(( max(min(s[0] + a[0], GRID), -GRID) , max(min(s[1] + a[1], GRID), -GRID)), 1)]}
		T = dict(T.items() + temporary.items() )


U = updateObj.value_iteration ( T , states, GRID)
policy = updateObj.best_policy(U, T, states, GRID)


for x in xrange(-GRID, GRID + 1):
	for y in xrange(-GRID, GRID + 1):
		a, b = policy[x, y]
		plt.quiver(x, y, a, b)

plt.xlim(-GRID - 1, GRID + 1)
plt.ylim(-GRID - 1, GRID + 1)
plt.show()