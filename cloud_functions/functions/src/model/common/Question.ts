export class Question{
    private _indexNo: number = 0;
    private _question: string = "";
    private _answer: boolean = false;
    private _moveCount: number = 0;
    private _important: boolean = false;

    public constructor(indexNo: number, question: string, answer: boolean, moveCount: number, important: boolean) {
        this._indexNo = indexNo;
        this._question = question;
        this._answer = answer;
        this._moveCount = moveCount;
        this._important = important;
    }


    get indexNo(): number {
        return this._indexNo;
    }

    set indexNo(value: number) {
        this._indexNo = value;
    }

    get question(): string {
        return this._question;
    }

    set question(value: string) {
        this._question = value;
    }

    get answer(): boolean {
        return this._answer;
    }

    set answer(value: boolean) {
        this._answer = value;
    }

    get moveCount(): number {
        return this._moveCount;
    }

    set moveCount(value: number) {
        this._moveCount = value;
    }

    get important(): boolean {
        return this._important;
    }

    set important(value: boolean) {
        this._important = value;
    }
}