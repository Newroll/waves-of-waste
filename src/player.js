import * as PIXI from 'pixi.js';

export class player {
    sprite: PIXI.Sprite;

    constructor(imageUrl: string) {
        this.sprite = PIXI.Sprite.from(imageUrl);
    }

    addToStage(stage: PIXI.Container) {
        stage.addChild(this.sprite);
    }
}