import { Binding } from '../service.js';
import { Variable } from '../variable.js';
type Dep<T> = Binding<any, any, T>;
export declare function merge<V, const Deps extends Dep<unknown>[], Args extends {
    [K in keyof Deps]: Deps[K] extends Dep<infer T> ? T : never;
}>(deps: Deps, fn: (...args: Args) => V): Binding<Variable<V>, "is_listening" | "is_polling" | Exclude<V extends (...args: any[]) => any ? never : "value", "g_type_instance">, V>;
export declare function derive<V, const Deps extends Variable<any>[], Args extends {
    [K in keyof Deps]: Deps[K] extends Variable<infer T> ? T : never;
}>(deps: Deps, fn: (...args: Args) => V): Variable<V>;
export {};
