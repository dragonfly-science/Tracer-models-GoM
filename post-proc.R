#### Setup #####

require(dplyr)

curl::curl_download('https://gom-diets.s3.amazonaws.com/GoM_tracers.Rdata', 
                    destfile = 'GoM_tracers.Rdata',
                    quiet = F)

load('GoM_tracers.Rdata')

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

mean_diet_props <- lapply(modlist, function(l) {
  props <- rstan::get_posterior_mean(l$mod,pars='prop')
  props <- data.frame(Prey=l$prey,Props = props[,ncol(props)])
}) %>% bind_rows(.id = 'Species')

rownames(mean_diet_props) <- NULL

#############################################
############ Now draw diet proportions   ####
#############################################

mean_diet_props 

# Note, each line is 1 sample = sums to 1
draw_diets(diet_props, 'Blue crab PS',        nsamples = 100)
draw_diets(diet_props, 'Killifish PS',        nsamples = 100)
draw_diets(diet_props, 'Atlantic Croaker PS', nsamples = 100)

draw_diets(diet_props, 'Blue crab WPH',        nsamples = 100)
draw_diets(diet_props, 'Killifish WPH',        nsamples = 100)
draw_diets(diet_props, 'Atlantic Croaker WPH', nsamples = 100)

