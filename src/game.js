const app = new PIXI.Application();
await app.init({ width: window.innerWidth - window.innerHeight/20, height: window.innerHeight - window.innerHeight/20 })
document.body.appendChild(app.canvas);

      // Create the sprite and add it to the stage
      await PIXI.Assets.load('https://pixijs.com/assets/files/sample-747abf529b135a1f549dff3ec846afbc.png');
      let sprite = PIXI.Sprite.from('https://pixijs.com/assets/files/sample-747abf529b135a1f549dff3ec846afbc.png');
      app.stage.addChild(sprite);

      // Add a ticker callback to move the sprite back and forth
      let elapsed = 0.0;
      app.ticker.add((ticker) => {
        elapsed += ticker.deltaTime;
        sprite.x = 100.0 + Math.cos(elapsed/50.0) * 100.0;
      });