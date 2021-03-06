context("Fitting and plotting explanations")

set.seed(1)
X <- tibble::as_tibble(MASS::mvrnorm(50, rep(0, 10), diag(1, 10)))
local <- live::sample_locally(data = X,
                              explained_instance = X[3, ],
                              explained_var = "V1",
                              size = 50)
local1 <- live::add_predictions(local, "regr.lm", X)
local_explained <- live::fit_explanation(local1, "regr.lm")

test_that("White box model is fitted correctly", {
  expect_is(local_explained, "live_explainer")
  expect_is(mlr::getLearnerModel(local_explained$model), "lm")
})

test_that("Plots are created without problems", {
  expect_output(plot(local_explained, type = "waterfall"), regexp = NA)
  expect_output(plot(local_explained, type = "forest"), regexp = NA)
})

