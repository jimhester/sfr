context("st_read")

test_that("st_read and write handle date and time", {
  library(sf)
  Sys.setenv(TZ="UTC")
  x = st_sf(a = 1:2, b=c(5.6,3), dt = Sys.Date()+1:2, tm = Sys.time()+2:3, 
	  geometry = st_sfc(st_point(c(1,1)),st_point(c(2,2))))
  shp <- paste0(tempfile(), ".shp")
  gpkg <- paste0(tempfile(), ".gpkg")
  st_write(x[-4], shp, quiet = TRUE)
  x2 = st_read(shp, quiet = TRUE)
  expect_equal(x[-4], x2)
  if (Sys.getenv("USER") %in% c("edzer", "travis")) { # 
     x = st_sf(a = 1:2, b=c(5.6,3), dt = Sys.Date()+1:2, tm = Sys.time()+2:3, 
	    geom = st_sfc(st_point(c(1,1)),st_point(c(2,2))))
     st_write(x, gpkg, quiet = TRUE)
	 x2 = st_read(gpkg, quiet = TRUE)
     expect_equal(x, x2)
  }
})
