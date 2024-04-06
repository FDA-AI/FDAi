import { GET } from '@/app/api';

export default async function UnitsPage() {
  const results = await GET('/units', {
    params: { query: {  } },
  });

  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <div className="grid my-10 grid-cols-1 md:grid-cols-3 gap-4">
        {results.data?.map((item) => (
          <div key={item.id} className="card bg-white rounded-lg shadow-md p-4 text-black">
            <div className="flex items-center">
              <img src={item.image} alt={item.name} className="w-16 h-16 object-cover mr-4" />
              <div>
                <h2 className="text-lg font-bold">{item.name}</h2>
                <p>{item.categoryName}</p>
              </div>
            </div>
          </div>
        ))}
      </div>
    </main>
  );
}
