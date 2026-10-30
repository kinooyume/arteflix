let load: string => promise<ArteRoutes.t> = %raw(`lang => import("./" + lang + ".json").then(m => m.default)`)
