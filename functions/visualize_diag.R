visualize_diag <- function(sparse_matrix, many_models){
    
    heldout <- make.heldout(sparse_matrix)
    
    k_result <- many_models %>%
        mutate(exclusivity = purrr::map(topic_model, exclusivity),
               semantic_coherence = purrr::map(topic_model, semanticCoherence, sparse_matrix),
               eval_heldout = purrr::map(topic_model, eval.heldout, heldout$missing),
               residual = purrr::map(topic_model, checkResiduals, sparse_matrix),
               bound =  map_dbl(topic_model, function(x) max(x$convergence$bound)),
               lfact = map_dbl(topic_model, function(x) lfactorial(x$settings$dim$K)),
               lbound = bound + lfact,
               iterations = map_dbl(topic_model, function(x) length(x$convergence$bound)))
    
    k_result %>%
        transmute(K,
                  `Lower bound` = lbound,
                  Residuals = map_dbl(residual, "dispersion"),
                  `Semantic coherence` = map_dbl(semantic_coherence, mean),
                  `Held-out likelihood` = map_dbl(eval_heldout, "expected.heldout")) %>%
        gather(Metric, Value, -K) %>%
        ggplot(aes(K, Value, color = Metric)) +
        geom_line(size = 1.5, alpha = 0.7, show.legend = FALSE) +
        facet_wrap(~Metric, scales = "free_y") +
        labs(x = "K (number of topics)",
             y = NULL,
             title = "Model diagnostics by number of topics")}
