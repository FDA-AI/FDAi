import { GET } from '@/app/api';

export default async function WildcardModelPage({ params }) {
  debugger
  const wildcardSegment = params.wildcard_model_name;
  let data = await GET(`/${wildcardSegment}`, {
    params: { query: {} },
  });
  if(data.data){
    data = data.data
  }

  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <div className="grid my-10 grid-cols-1 md:grid-cols-3 gap-4">
        {data.map((item) => (
          <a href={item.url} key={item.id} className="card bg-white rounded-lg shadow-md p-4 text-black">
            <div className="flex items-center">
              <img src={item.image || item.imageUrl} alt={item.name || item.variableName} className="w-16 h-16 object-cover mr-4" />
              <div>
                <h2 className="text-lg font-bold">{item.name}</h2>
                <p>{item.displayValueAndUnitString || item.categoryName}</p>
              </div>
            </div>
          </a>
        ))}
      </div>
    </main>
  );
}
