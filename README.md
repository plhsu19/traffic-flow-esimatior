# Thesis Project: Data-Driven Traffic Prediction
As a part of TENS-Project with RISE: http://www.tens-project.info/
### Goal
The goal of the project is to provide a data-driven approach based on machine learning methods to predict/estimate the traffic flow on highway E4 in Stockholm using data extracted from different sensor sources, e.g., mobile data (INRIX) gathered form probe vehicles and traditional traffic data (MCS) from stationary radar sensors installed on highways.

### Data Sources
1. INRIX (probe-based enabled traffic control): https://inrix.com/
2. Motorway Control System (MCS): Data collected by Stockholm's city with radar sensors installed in road sections.

### Steps
1. Extract traffic data from the sensor's database and preprocess the datasets, e.g., data cleaning, data-type converting, unit transferring.
2. Perform explorative analyses of mobile and stationary datasets.
3. Join different sensors' datasets according to data rows' timestamp.
4. Use feature engineering to create new features, e.g., temporal segmentation, based on the datasets' original features.
5. Implement and evaluate different methods, e.g., neural network or decision tree, for predicting traffic flow based on information provided by traffic sensors, e.g., vehicles' speed and travel time. 
6. Select the best method, i.e., neural network, as the final predictor and deploy the predictor as a web API service on Google Cloud AI Platform.
7. (Build the pipeline to automate the building of prediction models from raw traffic data gathered from different road segments in the traffic network.)

### How to use
1. Copy source data files in the <strong>Data</strong> directory to any Google Drive's directory.
2. Download and open the "traffic_flow_estimation.ipynb" in the <strong>src</strong> directory in Google Colab.
3. Mount the directory with source data as the working directory in "traffic_flow_estimation.ipynb"
4. Run the rest of scripts in traffic_flow_estimation.ipynb to build the traffic flow estimation model and generate the estimation results.
