visualize_diag <- function(sparse_matrix, many_models){
    
    k_result <- many_models %>%
        mutate(exclusivity = purrr::map(topic_model, exclusivity),
               semantic_coherence = purrr::map(topic_model, semanticCoherence, sparse_matrix))
    
    
    k_result %>%
        transmute(K,
                  "Exclusivity" = map_dbl(exclusivity, mean),
                  "Semantic coherence" = map_dbl(semantic_coherence, mean)) %>%
        pivot_longer(cols = c("Exclusivity", "Semantic coherence"),
                     names_to = "Metric",
                     values_to = "Value") %>%
        ggplot(aes(K, Value, color = Metric)) +
        geom_line(size = 1.5, show.legend = FALSE) +
            labs(x = "K (number of topics)",
                 y = NULL) +   
            facet_wrap(~Metric, scales = "free_y") +
            theme_pubr()
        
        }
