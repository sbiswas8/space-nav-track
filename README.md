# Navigation and tracking in space: Analysis and Algorithms

## by Sanat K. Biswas and Andrew G. Dempster

This is the repository of the accompanying MATLAB codes for the Book Navigation and Tracking in Space: Analysis and Algorithms.

## Repository structure
This repository has 4 folders:
- **chapter_5:** contains MATLAB codes and data corresponding to the satellite navigation example provided in Chapter 5 section 4
- **chapter_6:**
    - **reentry:** contains MATLAB codes and data corresponding to the reentry vehicle tracking example provided in Chapter 6 section 4.1
    - **launch:** contains MATLAB codes and data corresponding to the launch vehicle navigation example provided in Chapter 6 section 4.2
- **chapter_7:** contains MATLAB codes and data corresponding to the tracking of spacecraft in a lunar transfer trajectory example provided in Chapter 7 section 6
- **estimation-algorithms:** contains the MATLAB implementations of the Extended Kalman Filter (EKF), Unscented Kalman Filter (UKF), Single Propagation Unscented Kalman Filter (SPUKF), Extrapolated Single Propagation Unscented Kalman Filter (ESPUKF), particle filter and Extrapolated Single Propagation Particle Filter (ESP-PF). The code descriptions are provided in Chapter 4 section 7

## Using the repository
1. Clone the repository to the local workstation
2. Add **estimation-algorithms** folder to MATLAB path. See how to add a folder in the MATLAB path [here](https://in.mathworks.com/help/matlab/ref/path.html)
3. Run the example scripts

## Additional codes
The **estimation-algorithms** folder contains a particle filter example that is not included in the book.

## References
1. S. K. Biswas, L. Qiao and A. G. Dempster, "A Novel a Priori State Computation Strategy for the Unscented Kalman Filter to Improve Computational Efficiency," in IEEE Transactions on Automatic Control, vol. 62, no. 4, pp. 1852-1864, April 2017. doi: 10.1109/TAC.2016.2599291 

2. S. K. Biswas and A. G. Dempster, “Approximating Sample State Vectors Using the ESPT for Computationally Efficient Particle Filtering,” IEEE Transactions on Signal Processing, vol. 67, no. 7, pp. 1918–1928, Apr. 2019.

3. S. K. Biswas, L. Qiao, and A. G. Dempster, “A quantified approach of predicting suitability of using the Unscented Kalman Filter in a non-linear application,” Automatica, vol. 122, p. 109241, Dec. 2020, doi: 10.1016/j.automatica.2020.109241.

## Citing the SPUKF and ESPUKF
S. K. Biswas, L. Qiao and A. G. Dempster, "A Novel a Priori State Computation Strategy for the Unscented Kalman Filter to Improve Computational Efficiency," in IEEE Transactions on Automatic Control, vol. 62, no. 4, pp. 1852-1864, April 2017. doi: 10.1109/TAC.2016.2599291

## Citing the ESP-PF
S. K. Biswas and A. G. Dempster, “Approximating Sample State Vectors Using the ESPT for Computationally Efficient Particle Filtering,” IEEE Transactions on Signal Processing, vol. 67, no. 7, pp. 1918–1928, Apr. 2019.
