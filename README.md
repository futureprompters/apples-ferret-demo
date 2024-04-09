---
title: Apple's Ferret
emoji: 🦦
colorFrom: gray
colorTo: pink
sdk: docker
pinned: false
license: llama2
app_port: 7860
---

<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
<!-- [![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url] -->



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/futureprompters/apples-ferret-demo">
    <img src="images/logo-fp-color-black.png" alt="Logo" width="430" height="135">
  </a>
<br/>
<br/>
<h1 align="center">Apple's Ferret Demo</h1>

  <p align="center">
    The project brings Ferret, Apple's state-of-the-art multimodal LLM, to Hugging Face Spaces for interactive visual and textual analysis.
    <br />
    <a href="https://huggingface.co/spaces/FuturePrompters/apples-ferret"><strong>Play with the Demo at 🤗 HF Spaces »</strong></a>
    <br />
    <br />
    <a href="https://github.com/apple/ml-ferret">🦦 Ferret's Repo</a>
    ·
    <a href="https://arxiv.org/abs/2310.07704">Paper</a>
  </p>
</div>

## About The Project

Our project brings **Apple's groundbreaking multimodal large language model (MLLM), Ferret**, to life on 🤗 Hugging Face Spaces. Developed in collaboration between Apple and Cornell University researchers, Ferret represents a **significant leap** in AI's ability to engage with and understand visual content at an unprecedented granularity. Leveraging a **hybrid region representation and a spatial-aware visual sampler**, Ferret excels at fine-grained referring and grounding tasks, making it possible to refer to and **ground anything, anywhere in an image**, with any form of referring expression.

By deploying Ferret, we aim to **explore and demonstrate its unique capabilities** in creating more nuanced and contextually rich interactions between AI and visual content. This includes **identifying objects**, **understanding relationships within images**, and **grounding textual concepts to specific visual elements**. Our implementation on 🤗 Hugging Face Spaces allows users to interact with Ferret in real-time, providing a tangible demonstration of its potential to revolutionize how AI perceives and discusses visual information.

### Key Features of Our Project:

- **Real-Time Interaction**: Users can directly interact with Ferret through a Gradio-based web interface, enabling instant visual and textual dialogues.
- **Demonstration of Advanced AI**: Showcases Ferret's hybrid approach to visual and textual data processing, blending computer vision and natural language processing for enriched multimodal communication.
- **Accessibility**: By hosting Ferret on Hugging Face Spaces, we provide easy access to this advanced technology, fostering broader experimentation and understanding within the AI community.
- **Educational Tool**: Acts as a resource for researchers, developers, and enthusiasts to study and understand the intricacies of multimodal AI systems, particularly in referring and grounding tasks.

Give it a shot and play with the Ferret on [🤗 HF Spaces](https://huggingface.co/spaces/FuturePrompters/apples-ferret)

https://github.com/futureprompters/apples-ferret-demo/assets/157353109/3313261c-8c40-4447-86b3-8025de048c42

## Technical Details

This section outlines the key technical aspects of our Ferret deployment, including the generation of model weights, model foundations, and the hardware requirements for using the current weight configurations.

### Generation of Weights and Storage
- **Weight Generation**: We followed Apple's guidelines to generate Ferret's weights, involving the application of delta weights to Vicuna's base weights to produce the final model. This process ensures that Ferret inherits Vicuna's robust linguistic capabilities while integrating its own advanced visual understanding.
- **Storage Location**: The generated model weights are hosted on Hugging Face at [FuturePrompters/apples-ferret](https://huggingface.co/FuturePrompters/apples-ferret), ensuring easy access for deployment and experimentation.
- **Reproduce**: In order to reproduce the weights manually, one may [use script](https://huggingface.co/FuturePrompters/apples-ferret/blob/main/ferret-7b-v1-3/reproduce.sh) prepared for this occassion.

### Model Foundations
Ferret is built upon the LLaVA v.1.3 framework, leveraging Vicuna v.1.3 for its linguistic processing. This foundation provides Ferret with a sophisticated understanding of language, combined with its unique visual comprehension capabilities. It's important to note that the model, as configured, requires a GPU to run effectively due to the computational demands of processing multimodal data.

## Local Deployment

Our deployment of Ferret has been dockerized to streamline the setup process and ensure consistency across different environments. Below are the details on how to deploy Ferret locally, the processes it initiates, and how to interact with the Gradio-based UI.

### Prerequisites

Before proceeding with the local deployment of Ferret, it's essential to ensure that your system meets the following prerequisites:

**Docker**: Docker must be installed and running on your machine. Docker is used to containerize the Ferret environment, ensuring that it can be deployed consistently across any platform. If you haven't installed Docker yet, visit the [official Docker website](https://www.docker.com/get-started) for installation instructions tailored to your operating system.

Having Docker installed is crucial for the deployment process, as it encapsulates the Ferret application and its dependencies within a container, simplifying the setup and execution steps. This approach also isolates the Ferret environment from your system, minimizing potential conflicts with existing software or dependencies.

**GPU**: To load the model into the GPU, **approximately 13.5GB of VRAM is required**. This is a crucial consideration for deploying Ferret, as the intensive computational tasks performed by the model necessitate significant memory bandwidth and capacity.

### Dockerized Deployment
To deploy Ferret locally, utilize the following Docker commands. These steps will prepare your environment for running Ferret:
- Build the image
  ```bash
  docker build -t ferret .
  ```
- Run the image with exposure of Gradio's port
  ```bash
  docker run ferret -p 7860:7860
  ```
- Access the Gradio based UI via Web Browser - http://0.0.0.0:7860/

### Underlying Processes
When the `app.py` entrypoint is being run, three main processes are initiated:
1. **Controller Thread**: Starts a controller that listens on port 10000, managing the overall application flow.
2. **Gradio Web Server Thread**: Launches a Gradio web server, enabling the interactive UI for user interactions.
3. **Model Worker Thread**: Begins a model worker process that handles inference tasks. This worker loads the Ferret model and performs the computational processing necessary for responding to user queries.

Each process operates in its own thread, ensuring efficient management of tasks and smooth user experience.

### Accessing the Gradio-based UI
Once the Docker container is up and running, and the processes outlined above are initiated, you can access Ferret's interactive UI through the Gradio web interface. This interface allows users to interact with Ferret in real-time, engaging in visual and textual dialogues. The Gradio-based UI is designed to be intuitive, making it easy for users to explore Ferret's capabilities by uploading images and posing questions or commands related to the visual content.

Usually, the Gradio UI should be accessible via http://0.0.0.0:7860/

By following these guidelines, you can effectively deploy Ferret within a local environment, leveraging its advanced multimodal conversational features through a user-friendly interface.

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Our project and its deployment on Hugging Face Spaces, including the modifications and use of the code, are based entirely on Apple Inc.'s original Ferret software and its associated licensing terms. It is crucial for users and contributors to our project to recognize and respect the copyright and licensing terms as established by Apple Inc.

This project is intended for research and educational purposes, aiming to explore and demonstrate the capabilities of multimodal large language models like Ferret. We encourage users to engage with our project within the bounds of Apple's licensing terms and with a commitment to fostering an environment of respect and innovation.

For further details about the license and your obligations as a user or contributor, please refer to the [original license agreement](https://github.com/apple/ml-ferret/blob/main/LICENSE) provided by Apple Inc. within the Ferret repository. It is the responsibility of each individual to ensure their use of the Ferret software complies with the specified terms.

## Acknowledgments

* [🦦 Apple's Ferret Original Repository](https://github.com/apple/ml-ferret)

## About The Future Prompters
TODO
