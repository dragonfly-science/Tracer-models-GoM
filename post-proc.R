diet_props <- lapply(modlist, function(l) {
  props <- rstan::extract(l$mod,pars='prop')$prop
  colnames(props) <- l$prey
  reshape2::melt(props)
}) %>% bind_rows(.id = 'Species')

colnames(diet_props)[2:3] <- c('iter', 'Prey')

draw_diets <- function(diets, predator, nsamples){
  
  this.out <- diets[diets$Species == predator,]
  samples <- sample(max(this.out$iter), nsamples)
  
  out <- this.out[this.out$iter %in% samples,]
  tidyr::pivot_wider(out, names_from = Prey, values_from = value)[,-c(1,2)]
}

draw_diets(diet_props, 'Atlantic Croaker PS', 1000)
