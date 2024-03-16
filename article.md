<style>
img {
  padding-left:10px;
  padding-right:10px;
}
</style>

# Constructing Binary Decision Diagrams (BDDs)

We cover a couple of examples of constructing BDDs from propositional formulae.

Note: our ordering of propositional letters is alphabetical, e.g. $P$ then $Q$ then $R$.

# $\neg R \rightarrow (Q \wedge P)$

We start by computing the BDD for $\neg R \rightarrow (Q \wedge P)$. On the left of the image below we see the BDD for $\neg R$, and on the right the BDD for $Q \wedge P$. The implication symbol inbetween them is drawn as a reminder of the connective that we're applying.

<p align="center">
  <img src="build/out_1.png" width="auto" height="250px">
</p>

We case split on the $P$ node, for each BDD getting the sub-BDD following the $P=0$ path, and the $P=1$ path.

## Aside: Sub-BDDs?

Below we see highlighted the two sub-BDDs that we get, the first if we take the $$P=0$$ path, the second the $$P=1$$ path.

<p align="center">
  <img src="build/c_1.png" width="auto" height="350px">
  <img src="build/c_2.png" width="auto" height="350px">
</p>


## $P=0$

The left BDD has no $P$ node, and so is left unchanged. In the right BDD we simply get the $0$ (zero) leaf node.

<p align="center">
  <img src="build/out_2.png" width="auto" height="180px">
</p>

We could now case split on $R$ and continue the recursion, but now that we've encountered a leaf node we can just compute the result of the connective applied to each of the leaves of the left sub-BDD with the boolean value on the right. This would give us $0 \rightarrow 0 = 1$ if $R=1$ and $1 \rightarrow 0 = 0$ if $R=0$. Effectively this has swapped the outgoing edges of the $R$ node, producing the below BDD.

<p align="center">
  <img src="build/R.png" width="auto" height="180px">
</p>

We can now recurse upwards and attach the $P=0$ edge to this new sub-BDD.

<p align="center">
  <img src="build/a_1.png" width="auto" height="300px">
</p>

We now turn to the $P=1$ case.

## $P=1$

We need the sub-BDDs produced by following the $P=1$ edge for each of the initial BDDs, giving us

<p align="center">
  <img src="build/out_3.png" width="auto" height="180px">
</p>

As we don't have any leaf nodes, we can recurse again, now on $Q$.

## $Q=0$

Following the $Q=0$ path gives us

<p align="center">
  <img src="build/out_4.png" width="auto" height="180px">
</p>

which produces 

<p align="center">
  <img src="build/R.png" width="auto" height="180px">
</p>

## $Q=1$

Recursing upwards and following the $Q=1$ path gives us

<p align="center">
  <img src="build/out_5.png" width="auto" height="180px">
</p>

Doing the computation gives us a BDD where both the positive and negative edge of $R$ lead to a $1$ (one) leaf. This can be simplified by removing the redundant $R$ node and simply returning

<p align="center">
  <img src="build/1.png" width="auto" height="90px">
</p>

## Putting It Together

Recursing all the way up, we draw on our page the following tree,

<p align="center">
  <img src="build/a_2.png" width="auto" height="300px">
</p>

We first combine each of the $1$ and $0$ leaf nodes together, producing the BDD below on the left.

We can then remove duplicated nodes. Notice that both of the $R$ nodes have the exact same output edges. This means that we can combine these into one new node, which takes the input edges of both — in this case from $P$ and $R$. This gives us the BDD on the right, which is fully reduced.

<p align="center">
  <img src="build/a_3.png" width="auto" height="350px">
  <img src="build/not_P_implies_Q_and_R.png" width="auto" height="350px">
</p>

We have computed the Reduced, Ordered, Binary Decision Diagram (ROBDD) of $\neg R \rightarrow (Q \wedge P)$.

Note that the choice of connective had no impact for most of the execution of the algorithm. It is only at the leaf nodes that we directly computed the implication on boolean values, which is trivial for any operator we choose. Combining two BDDs with the exclusive or ($\oplus$) is exactly as simple as finding their conjunction ($\wedge$).

# $(\neg R \rightarrow (Q \wedge P)) \iff (P \wedge (Q \oplus R))$

We will now combine the BDD we produced above for $\neg R \rightarrow (Q \wedge P)$ with another BDD for $P \wedge (Q \oplus R)$ by the $\iff$ connective. We repeat the new BDD for the former on the left, and show the BDD for the latter on the right.

<p align="center">
  <img src="build/not_P_implies_Q_and_R.png" width="auto" height="350px">
  <img src="build/P_and_Q_xor_R.png" width="auto" height="350px">
</p>

It's easy to feel intimidated by the $\iff$ symbol and try to expand it out into its implication form, but this will make the task far more complex than it needs to be. As we saw above, the choice of connective makes no difference for 90% of the algorithm's execution.

We start by case splitting on the $P$ node. For each of the cases, we have two sub-BDDs gotten by following the choice for each BDD.

## $P=0$

The two sub-BDDs we get by following the $P=0$ choice for each BDD above are

<p align="center">
  <img src="build/R.png" align="center" width="auto" height="180px">
  <img src="build/0.png" align="center" width="auto" height="90px">
</p>

As we have reached a leaf node, we can apply the $\iff$ to it and each of the leaves of the other sub-BDD, giving us

<p align="center">
  <img src="build/not_R.png" align="center" width="auto" height="180px">
</p>

As this case is finished we can attach it to the $0$ branch of the $P$ node, and recurse into the $P=1$ case.

<p align="center">
  <img src="build/b_1.png" align="center" width="auto" height="300px">
</p>

## $P=1$

The two sub-BDDs we get by following the $P=1$ choice for each BDD are

<p align="center">
  <img src="build/Q_or_R.png" align="center" width="auto" height="250px">
  <img src="build/Q_xor_R.png" align="center" width="auto" height="250px">
</p>

We need to case split on the $Q$ node.

## $Q=0$

The two sub-BDDs we get by following the $Q=0$ choice are

<p align="center">
  <img src="build/R.png" align="center" width="auto" height="180px">
  <img src="build/R.png" align="center" width="auto" height="180px">
</p>

Case splitting on the $R$ node and applying the $\iff$ connective to each leaf, we get a BDD where both branches of $R$ lead to the same outcome. This node is redundant, and the BDD can be simplified into a $1$ node as follows.

<p align="center">
  <img src="build/b_2.png" align="center" width="auto" height="180px">
  <img src="build/b_3.png" align="center" width="auto" height="180px">
  <img src="build/1.png" align="center" width="auto" height="90px">
</p>

## $Q=1$

The two sub-BDDs are

<p align="center">
  <img src="build/1.png" align="center" width="auto" height="90px">
  <img src="build/not_R.png" align="center" width="auto" height="180px">
</p>

which, combined by $\iff$, gives us

<p align="center">
  <img src="build/not_R.png" align="center" width="auto" height="180px">
</p>

## Putting it together

As before, we reattach the new sub-BDDs and then combine duplicate nodes.

<p align="center">
  <img src="build/b_4.png" align="center" width="auto" height="300px">
  <img src="build/b_5.png" align="center" width="auto" height="350px">
</p>
