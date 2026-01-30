
# :::::::::::::::::: Basic descriptive stats :::::::::::::::::::


# ::::::::::::: Lower and Upper Limits of 95% confidence Intervals ::::::::::::


LL <- function(x) { quantile(x, probs=c(.025)) }
UL <- function(x) { quantile(x, probs=c(.975)) }

# :::::::::::::::::::::::::::::::::::::::::::::::::: Functions for Simulation ::::::::::::::::::::::::::::::::::::::::::::::::::

# Note: These functions need a dataframe that contains ALL the variables used in the functions.
# Such dataframe is generated after models are fitted.


# Computes mean with na.rm=TRUE by default

Mean <- function(x) {
	m <- mean(x, na.rm=TRUE)
	return(Mean = m)
}


# Computes Gini coefficient

Gini <- function(x) {
	gini.coeff <- ineq(x, type="Gini", na.rm=TRUE)
	return(gini = gini.coeff)
}

# Computes Theil T (Theil's entropy measure)

Theil.T <- function(x) {
	theil.index <- ineq(x, parameter=0, type="Theil", na.rm=TRUE)
	return(theil.t = theil.index)
}


# Computes Theil L ( second Theil measure or mean logarithmic deviation )

Theil.L <- function(x) {
	theil.index <- ineq(x, parameter=1, type="Theil", na.rm=TRUE)
	return(Theil.l = theil.index)
}


# Computes Ratio 90/10

R9020 <- function(x) { 
	ratio = quantile(x, probs=c(.9), na.rm=TRUE)/quantile(x, probs=c(.2), na.rm=TRUE); names(ratio) <- "Ratio 90/20"
	return(r9020 = ratio)
}

# Computes Ratio 90/50

R9050 <- function(x) { 
	ratio = quantile(x, probs=c(.9), na.rm=TRUE)/quantile(x, probs=c(.5), na.rm=TRUE); names(ratio) <- "Ratio 90/50"
	return(r9050 = ratio)
}

# Computes Ratio 50/20

R5020 <- function(x) { 
	ratio = quantile(x, probs=c(.5), na.rm=TRUE)/quantile(x, probs=c(.2), na.rm=TRUE); names(ratio) <- "Ratio 50/20"
	return(r5020 = ratio)
}




