import { Assets } from 'pixi.js';

const sheetTexture = await Assets.load('/assets/player/move_down.png');
Assets.add({
    alias: 'atlas',
    src: '/assets/player/move_down.json'
    data: {texture: sheetTexture}
});
const sheet = await Assets.load('atlas')