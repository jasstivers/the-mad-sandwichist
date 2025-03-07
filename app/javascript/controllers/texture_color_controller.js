import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["textureBox"]

  connect() {
    console.log("TextureColorController is connected!");
    this.randomizeBoxColors();
  }

  randomizeBoxColors() {
    const colors = [
      '#FF5733', '#33FF57', '#5733FF', '#FFC300', '#FF33A1', '#33FFBD', '#FF6F61'
    ];

    const shuffledColors = [...colors];
    this.shuffleArray(shuffledColors);

    this.textureBoxTargets.forEach((box, index) => {
      const randomColor = shuffledColors[index % shuffledColors.length];
      box.style.backgroundColor = randomColor;
    });
  }

  shuffleArray(array) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
  }
}
