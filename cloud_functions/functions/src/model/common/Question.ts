export class Question{
    private _indexNo: string = "";
    private _question: string = "";
    private _answer: boolean = false;
    private _moveCount: number = 0;
    private _important: boolean = false;

    public constructor(indexNo: string, question: string, answer: boolean, moveCount: number, important: boolean) {
        this._indexNo = indexNo;
        this._question = question;
        this._answer = answer;
        this._moveCount = moveCount;
        this._important = important;
    }


    get indexNo(): string {
        return this._indexNo;
    }

    set indexNo(value: string) {
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