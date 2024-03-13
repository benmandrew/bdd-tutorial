Our ordering of propositional letters is alphabetical, i.e. $P$ then $Q$ then $R$.

# $\neg R \rightarrow (Q \wedge P)$

We start by computing the BDD for $\neg R \rightarrow (Q \wedge P)$. On the left of the image below we see the BDD for $\neg R$, and on the right the BDD for $Q \wedge P$. The implication symbol inbetween them is drawn as a reminder of the connective that we're applying.

<p align="center">
  <img src="build/out_1.png" width="auto" height="250px">
</p>

We case split on the $P$ node, for each BDD getting the subtree following the $P=0$ path, and the $P=1$ path.

## $P=0$

The left BDD has no $P$ node, and so is left unchanged. In the right BDD we simply get the $0$ (zero) leaf node.

<p align="center">
  <img src="build/out_2.png" width="auto" height="180px">
</p>

We could now case split on $R$ and continue the recursion, but now that we've encountered a leaf node we can just compute the result of the connective applied to each of the leaves of the left subtree with the boolean value on the right. This would give us $0 \rightarrow 0 = 1$ if $R=1$ and $1 \rightarrow 0 = 0$ if $R=0$. Effectively this has swapped the outgoing edges of the $R$ node, producing the below BDD.

<p align="center">
  <img src="build/R.png" width="auto" height="180px">
</p>

We can now recurse upwards and attach the $P=0$ edge to this new subtree.

<p align="center">
  <img src="build/out_9.png" width="auto" height="300px">
</p>

We now turn to the $P=1$ case.

## $P=1$

We need the subtrees produced by following the $P=1$ edge for each of the initial BDDs, giving us

<p align="center">
  <img src="build/out_4.png" width="auto" height="180px">
</p>

As we don't have any leaf nodes, we can recurse again, now on $Q$.

## $Q=0$

Following the $Q=0$ path gives us

<p align="center">
  <img src="build/out_5.png" width="auto" height="180px">
</p>

which produces 

<p align="center">
  <img src="build/R.png" width="auto" height="180px">
</p>

## $Q=1$

Recursing upwards and following the $Q=1$ path gives us

<p align="center">
  <img src="build/out_6.png" width="auto" height="180px">
</p>

Doing the computation gives us a BDD where both the positive and negative edge of $R$ lead to a $1$ (one) leaf. This can be simplified by removing the redundant $R$ node and simply returning

<p align="center">
  <img src="build/1.png" width="auto" height="90px">
</p>

## Putting It Together

Recursing all the way up the tree, we draw on our page the following tree,

<p align="center">
  <img src="build/out_10.png" width="auto" height="300px">
</p>

We first combine each of the $1$ and $0$ leaf nodes together, producing the BDD below on the left.

We can then remove duplicated nodes. Notice that both of the $R$ nodes have the exact same output edges. This means that we can combine these into one new node, which takes the input edges of both — in this case from $P$ and $R$. This gives us the BDD on the right, which is fully reduced.

<p align="center">
  <img src="build/out_11.png" width="auto" height="350px">
  <img src="build/out_12.png" width="auto" height="350px">
</p>

We have computed the Reduced, Ordered, Binary Decision Diagram (ROBDD) of $\neg R \rightarrow (Q \wedge P)$.

Note that the choice of connective had no impact for most of the execution of the algorithm. It is only at the leaf nodes that we directly computed the implication on boolean values, which is trivial for any operator we choose. Combining two BDDs with the exclusive or ($\oplus$) is exactly as simple as finding their conjunction ($\wedge$).

