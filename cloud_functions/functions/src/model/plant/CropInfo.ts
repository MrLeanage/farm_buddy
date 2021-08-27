export class CropInfo{
    private _cropID : string = "";
    private _name : string = "";
    private _description : string = "";
    private _imageURL : string = "";
    private _lifeSpan : string = "";


    constructor(cropID: string, name: string, description: string, imageURL: string, lifeSpan: string) {
        this._cropID = cropID;
        this._name = name;
        this._description = description;
        this._imageURL = imageURL;
        this._lifeSpan = lifeSpan;
    }


    get cropID(): string {
        return this._cropID;
    }

    set cropID(value: string) {
        this._cropID = value;
    }

    get name(): string {
        return this._name;
    }

    set name(value: string) {
        this._name = value;
    }

    get description(): string {
        return this._description;
    }

    set description(value: string) {
        this._description = value;
    }

    get imageURL(): string {
        return this._imageURL;
    }

    set imageURL(value: string) {
        this._imageURL = value;
    }

    get lifeSpan(): string {
        return this._lifeSpan;
    }

    set lifeSpan(value: string) {
        this._lifeSpan = value;
    }
}